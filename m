Received: from eggs.gnu.org ([2001:4830:134:3::10]:59634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL28p-00013Y-Nf
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL28l-00071I-7E
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dL28l-00070y-1R
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:50:55 -0400
Date: Wed, 14 Jun 2017 14:50:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614065048.GF25748@lemon>
References: <1497367206-4295-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<149736763578.138.3211408800921449558@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149736763578.138.3211408800921449558@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chugh.ishani@research.iiit.ac.in, jsnow@redhat.com, stefanha@redhat.com

On Tue, 06/13 08:27, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here
> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-q1s9ud16/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2

Not related to this patch - the bug is on master.

Fam

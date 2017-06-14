Received: from eggs.gnu.org ([2001:4830:134:3::10]:59945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL2A0-0001h2-Gp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL29w-0007ER-0X
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:52:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dL29v-0007EE-Ra
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:52:07 -0400
Date: Wed, 14 Jun 2017 14:52:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614065204.GH25748@lemon>
References: <20170613140546.28227-1-vadim.galitsyn@profitbricks.com>
	<149736595582.129.14995751172642560994@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149736595582.129.14995751172642560994@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vadim.galitsyn@profitbricks.com, dgilbert@redhat.com, armbru@redhat.com, vasilis.liaskovitis@profitbricks.com, mohammed.gamal@profitbricks.com, eduardo.otubo@profitbricks.com

On Tue, 06/13 07:59, no-reply@patchew.org wrote:
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
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-8l8x5wbj/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2

Not related to this patch. It's a bug on master.

Fam

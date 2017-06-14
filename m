Received: from eggs.gnu.org ([2001:4830:134:3::10]:34967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL2PD-0002ll-Cz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL2P9-0004Cw-DD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:07:55 -0400
Date: Wed, 14 Jun 2017 15:07:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614070743.GI25748@lemon>
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<149742310254.876.3220542367753320939@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149742310254.876.3220542367753320939@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v8 0/2] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Tue, 06/13 23:51, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here
> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....
>   CC      hw/net/ne2000-isa.o
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-v86bvvd0/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-q=
uick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2

Not related to this patch, the bug is on master.

Fam

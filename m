Received: from eggs.gnu.org ([2001:4830:134:3::10]:37337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqLym-0007cT-Sd
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqLyi-0007FD-QI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqLyi-0007Em-K3
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A80A1E30
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 15:45:44 +0000 (UTC)
References: <20170319094631.17298-1-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d97dfbf0-571e-180d-06e2-08351c97fce3@redhat.com>
Date: Tue, 21 Mar 2017 16:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170319094631.17298-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] New blog post: "QEMU in the
 blogs: February 2017"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 03/19/17 10:46, Paolo Bonzini wrote:
> Just an idea... If this is useful, we can do it every month.  It only
> takes ten minutes to skim planet.virt-tools.org and compile the list.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../2017-03-19-qemu-in-the-blogs-february-2017.md  | 33 ++++++++++++++=
++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 _posts/2017-03-19-qemu-in-the-blogs-february-2017.m=
d
>=20
> diff --git a/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md b/_po=
sts/2017-03-19-qemu-in-the-blogs-february-2017.md
> new file mode 100644
> index 0000000..dd080f1
> --- /dev/null
> +++ b/_posts/2017-03-19-qemu-in-the-blogs-february-2017.md
> @@ -0,0 +1,33 @@
> +---
> +layout: post
> +title:  "QEMU in the blogs: February 2017"
> +date:   2017-03-19 10:30:00 +0100
> +author: Paolo Bonzini
> +categories: blog posts
> +---
> +Here is a short list of articles and blog posts about QEMU
> +and KVM, that were posted last month.
> +
> +* [QEMU and the qcow2 metadata
> +  checks](https://blogs.igalia.com/berto/2017/02/08/qemu-and-the-qcow2=
-metadata-checks/)
> +  by Alberto Garcia
> +
> +* [Running Hyper-V in a QEMU/KVM
> +  Guest](https://ladipro.wordpress.com/2017/02/24/running-hyperv-in-kv=
m-guest/)
> +  by Ladislav Pro=C5=A1ek
> +
> +* [Setting up a nested KVM guest for developing & testing PCI device a=
ssignment
> +  with NUMA](https://www.berrange.com/posts/2017/02/16/setting-up-a-ne=
sted-kvm-guest-for-developing-testing-pci-device-assignment-with-numa/)
> +  by Daniel P. Berrang=C3=A9
> +
> +* [Testing SMM with QEMU, KVM and
> +  libvirt](https://github.com/tianocore/tianocore.github.io/wiki/Testi=
ng-SMM-with-QEMU,-KVM-and-libvirt)
> +  by L=C3=A1szl=C3=B3 Er=C5=A1ek

NAK, Er=C5=A1ek <-> =C3=89rsek :)

(Anyway, "Laszlo Ersek" is fully fine.)

Thanks!
Laszlo

> +
> +* [The surprisingly complicated world of disk image
> +  sizes](https://www.berrange.com/posts/2017/02/10/the-surprisingly-co=
mplicated-world-of-disk-image-sizes/)
> +  by Daniel P. Berrang=C3=A9
> +
> +
> +In other news, QEMU is now in hard freeze for release 2.9.0.  The prel=
iminary
> +list of features is on the [wiki](http://wiki.qemu-project.org/ChangeL=
og/2.9).
>=20

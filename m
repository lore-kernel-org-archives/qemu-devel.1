Received: from eggs.gnu.org ([2001:4830:134:3::10]:33837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAe9C-0001cg-97
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAe99-0002sQ-3B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:12:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAe98-0002sD-QO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:12:23 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9785861E4B
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 15:11:56 +0000 (UTC)
References: <1494947277-26158-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a30173fd-a272-30d6-9f6e-873e6a6bac40@redhat.com>
Date: Tue, 16 May 2017 17:11:50 +0200
MIME-Version: 1.0
In-Reply-To: <1494947277-26158-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a blog post with links to the
 presentations from the DevConf 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 16/05/2017 17:07, Thomas Huth wrote:
> This post provides links to the talks from the virtualization
> track at the DevConf 2017 in Brno.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: I've added links to all presentations from the virtualization
>  track ... not all of them are really related to QEMU, so not sure
>  whether this is appropriate for the QEMU blog ... but I thought it
>  would be nice to have a collection with all links, so I included all
>  of them here.

Cool!  Pushed, thanks.

Paolo

>  _posts/2017-05-16-devconf-presentations.md | 47 ++++++++++++++++++++++=
++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 _posts/2017-05-16-devconf-presentations.md
>=20
> diff --git a/_posts/2017-05-16-devconf-presentations.md b/_posts/2017-0=
5-16-devconf-presentations.md
> new file mode 100644
> index 0000000..1c67bd5
> --- /dev/null
> +++ b/_posts/2017-05-16-devconf-presentations.md
> @@ -0,0 +1,47 @@
> +---
> +layout: post
> +title:  "Presentations from DevConf 2017"
> +date:   2017-05-16 16:00:00 +0200
> +author: Thomas Huth
> +categories: presentations
> +---
> +There were a couple of QEMU / virtualization related talks at the
> +[DevConf 2017](https://devconf.cz/2017/) conference that took place at=
 the
> +end of January already, but so far we missed to gather the links to th=
e
> +recordings of these talks. So here is now the list:
> +
> +* [How to write a legacy storage device
> +   emulator](https://www.youtube.com/watch?v=3DnnMso6RmiOU&t=3D258)
> +  by John Snow
> +
> +* [GPU Passthrough using GNOME
> +   Boxes](https://www.youtube.com/watch?v=3DO33s1paYuYg&t=3D75)
> +  by Felipe Borges
> +
> +* [Self-virtualizing Linux on
> +   x86](https://www.youtube.com/watch?v=3DGn7Bdq9_cUA&t=3D118)
> +  by Radim Kr=C4=8Dm=C3=A1=C5=99=20
> +
> +* [New ways to remote desktops with GStreamer
> +   integration](https://www.youtube.com/watch?v=3DC5ox_M-k63w)
> +  by Victor Toso de Carvalho and Pavel Grunt
> +
> +* [Can VMs networking benefit from
> +   DPDK](https://www.youtube.com/watch?v=3Dcbm30mPp0hE&t=3D210)
> +  by Maxime Coquelin and Victor Kaplansky
> +
> +* [Windows VMs on KVM: The Good, the Bad and the
> +   Ugly](https://www.youtube.com/watch?v=3Do3TBT68xCm8&t=3D92)
> +  by Ladi Prosek
> +
> +* [Pet VMs in Kubernetes?
> +   WTH](https://www.youtube.com/watch?v=3D_w4roI9T7VE&t=3D85)
> +  by Fabian Deutsch
> +
> +* [Virtualization development improved with
> +   Lago](https://www.youtube.com/watch?v=3DChtZaG_60AQ&t=3D48)
> +  by Rafael Martins
> +
> +* [An ARMful of guests: virtualization on 64-bit
> +   ARM](https://www.youtube.com/watch?v=3Dx1a_f_2IMG8)
> +  by Andrea Bolognani
>=20

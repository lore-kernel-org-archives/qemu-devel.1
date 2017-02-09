Received: from eggs.gnu.org ([2001:4830:134:3::10]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbp9o-0007ow-Gx
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cbp9n-00034H-Jq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:08 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cbp9n-000348-FH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:07 -0500
Received: by mail-ua0-x235.google.com with SMTP id y9so3275276uae.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:53:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209101240.GJ22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
	<20170209014728.GF22807@lemon.lan>
	<CAO_EM_mJYNoxTLjKmTy18JhrL_zs_VLA32Y=Cw+LYqAGPzLN=w@mail.gmail.com>
	<20170209025212.GG22807@lemon.lan>
	<CAO_EM_kh1mQZNhjRKi458u15kj0G6t=UEFBvM+wWhOX1fyi6VQ@mail.gmail.com>
	<20170209101240.GJ22807@lemon.lan>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 9 Feb 2017 05:52:26 -0800
Message-ID: <CAO_EM_mhnd9-2B3vpLDa5eCyMh17e4UCYqe6nu-UqSDfhNAivA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Thu, Feb 9, 2017 at 2:12 AM, Fam Zheng <famz@redhat.com> wrote:
> This should fix it:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01874.html

I tested this patch and found it fixes the problem. Thanks for the
speedy response!

--Ed

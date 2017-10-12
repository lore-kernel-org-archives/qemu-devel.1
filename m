Received: from eggs.gnu.org ([2001:4830:134:3::10]:39595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2eI3-0005CM-Dm
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2eI2-0004Ei-HN
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:16:47 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:51662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2eI2-0004CR-8X
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:16:46 -0400
Received: by mail-wm0-x236.google.com with SMTP id f4so13835408wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 07:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012140159.GA11619@localhost.localdomain>
References: <CAFEAcA81AZBaGu6nrLK51_6vWApMSpMDhb9OsnkdApMGebYK8w@mail.gmail.com>
	<20171012140159.GA11619@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 15:16:24 +0100
Message-ID: <CAFEAcA-8tZZFL=tjgy=XFsoo=MiJ0EE_96j9amV-4aoVZ3vN2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu.org: new git repos to be mirrored
 (qemu-palcode, capstone, keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12 October 2017 at 15:01, Jeff Cody <jcody@redhat.com> wrote:
> Done.

Great, thanks.

> The git.qemu.org URLs are:
>
> git://git.qemu.org/capstone.git
> https://git.qemu.org/git/capstone.git
>
> git://git.qemu.org/keycodemapdb.git
> https://git.qemu.org/git/keycodemapdb.git
>
> git://git.qemu.org/qemu-palcode.git
> https://git.qemu.org/git/qemu-palcode.git
>
>
> And of course they can also be viewed via the gitweb interface:
>
> https://git.qemu.org/
>
>
> I have NOT set these to push to our github mirror account, since I assume it
> is read-only.  Would you prefer I go ahead and mirror them there as well,
> anyway?

We don't need them to be on  github, but on the other hand looking at
the github page https://github.com/qemu/ we seem to generally
have our other mirrors (eg u-boot, dtc) also pushed to github.
So I don't mind but we should I guess aim for consistency.

thanks
-- PMM

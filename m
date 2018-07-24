Received: from eggs.gnu.org ([2001:4830:134:3::10]:57714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhuk7-0005iU-HM
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhuk6-0001B0-Ki
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:40:35 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhuk6-0001AV-Cb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:40:34 -0400
Received: by mail-oi0-x234.google.com with SMTP id w126-v6so6617448oie.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:40:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723194521.26831-1-ehabkost@redhat.com>
References: <20180723194521.26831-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 11:40:13 +0100
Message-ID: <CAFEAcA-ot=2BVW0Pcrp5z2eTvbs7uniYyjd4PNMWZZ1CYU75Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Build fix for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 July 2018 at 20:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 9ba7dd14355bb7957680d5ef764471ab102df099:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2018-07-23' into staging (2018-07-23 15:15:46 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 5f00335aecafc9ad56592d943619d3252f8941f1:
>
>   i386: Rename enum CacheType members (2018-07-23 12:56:19 -0300)
>
> ----------------------------------------------------------------
> Fix for -rc2
>
> * Fix build failure on mips host
>
Applied, thanks.

-- PMM

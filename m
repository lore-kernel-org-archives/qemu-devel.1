Received: from eggs.gnu.org ([2001:4830:134:3::10]:54578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRdx5-0005Sy-Lm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRdx0-0003u4-D3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:02:59 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRdx0-0003mC-10
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:02:54 -0500
Received: by mail-oi1-x241.google.com with SMTP id w13so19304217oiw.9
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20181127064932.7299-1-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 14:02:41 +0000
Message-ID: <CAFEAcA8e9duWheN3xApCFDwoa2++swCn6LVs+zei+iiWk3sfbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Fixes 31 20181127 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, 27 Nov 2018 at 06:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5298f4d67a911dd9cefa4c4185eed242074d64c2:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-23 08:54:52 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-31-20181127-pull-request
>
> for you to fetch changes up to e1ca8f7e1915496148f6e0ce1f7c2309af013312:
>
>   qapi: add query-display-options command (2018-11-27 07:47:57 +0100)
>
> ----------------------------------------------------------------
> various bugfixes for 3.1: fmops, ps2, cirrus, hda, usb-host, qapi
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

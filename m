Received: from eggs.gnu.org ([2001:4830:134:3::10]:40774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjYry-0001hd-Fi
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjYrx-0003Gx-Gq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:06:42 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjYrx-0003Go-8s
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:06:41 -0500
Received: by mail-wr0-x22d.google.com with SMTP id u108so62222620wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 14:06:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
References: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 22:06:19 +0000
Message-ID: <CAFEAcA_=_bHK1HmkombKrGd6pKMnr8h+CSt=gyMTPuu57Cp4+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v3 0/3] audio patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 15:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Three little audio patches, adding replay support
> and fixing audio with SDL2.
>
> v3: really fix osx build failure.
>
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-audio-20170301-1
>
> for you to fetch changes up to bcf19777df78193f7cdb108a55db44fd4f20d5b5:
>
>   audio/sdlaudio: Allow audio playback with SDL2 (2017-03-01 15:12:03 +0100)
>
> ----------------------------------------------------------------
> audio: replay support, sdl2 fix.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

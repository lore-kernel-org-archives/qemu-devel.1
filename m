Received: from eggs.gnu.org ([2001:4830:134:3::10]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRjXS-00028x-6J
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRjXR-0006Kg-Ch
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:51:50 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:33901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRjXR-0006Ka-2k
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:51:49 -0500
Received: by mail-vk0-x236.google.com with SMTP id r136so17510085vke.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:51:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
References: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 17:51:27 +0000
Message-ID: <CAFEAcA9prWgapAv02EiB9m2h=Ued06M1BFrv1NfG-mtkFhGi1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] audio patch queue
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

On 11 January 2017 at 09:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the audio patch queue, with some fixes and cleanups.
>
> please pull,
>   Gerd
>
> The following changes since commit b44486dfb9447c88e4b216e730adcc780190852c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' into staging (2017-01-10 14:52:34 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-audio-20170111-1
>
> for you to fetch changes up to 11f547e58a08ea71a8a92d3ffe1e210b4b0b709c:
>
>   es1370: wire up reset via DeviceClass (2017-01-11 09:19:03 +0100)
>
> ----------------------------------------------------------------
> audio: qomify drivers, hotplug fixes.

Applied, thanks.

-- PMM

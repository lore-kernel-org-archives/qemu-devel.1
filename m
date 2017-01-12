Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRk8K-0006eq-UD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRk8J-0005Bs-Vl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:29:56 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:34460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRk8J-0005BW-Hb
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:29:55 -0500
Received: by mail-vk0-x22a.google.com with SMTP id r136so18221752vke.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:29:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 18:29:34 +0000
Message-ID: <CAFEAcA_OG0RCscO2CefruZP0WRnDFYZSvt0a5QK+GE7KbkhFTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] vga patch queue
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

On 11 January 2017 at 10:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the vga patch queue, with more bugfixes, one missed the
> previously pull by mistake, the other ones are revent posts on the list.
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
>   git://git.kraxel.org/qemu tags/pull-vga-20170111-1
>
> for you to fetch changes up to a2056e09b02745e5d000351a8a7938fa8a292ba7:
>
>   virtio-gpu: tag as not hotpluggable (2017-01-11 09:19:05 +0100)
>
> ----------------------------------------------------------------
> vga: fixes for virtio-gpu and cirrus.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

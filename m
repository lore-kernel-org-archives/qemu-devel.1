Received: from eggs.gnu.org ([2001:4830:134:3::10]:46261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1enfaH-0000sY-0G
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1enfaC-00052a-13
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:09:56 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1enfaB-00052U-Pk
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:09:51 -0500
Received: by mail-wr0-f181.google.com with SMTP id m5so8532210wrg.1
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 23:09:51 -0800 (PST)
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
Date: Mon, 19 Feb 2018 08:09:47 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu SDL2 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 18.02.2018 11:11, Howard Spoelstra wrote:
> Hi,
> 
> I'd like to report a bug when using the SDL2 GUI in both Linux and
> Windows, which can be observed with in my case latest qemu-system-ppc
> running parallel instances of OSX 10.4 and 10.3.
> 
> After switching back and forth between GUIs, dragging becomes copying,
> keyboard starts using a strange character set.
> An additional "Alt" key press is needed to restore normal behaviour.

 Hi,

how do you switch back and forth between GUIs? Using the mouse or a
keystroke? I guess the latter ... sounds like the Alt key could be
"stuck" in the guest?

 Thomas

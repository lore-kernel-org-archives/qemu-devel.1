Received: from eggs.gnu.org ([2001:4830:134:3::10]:40327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpIXX-0003MD-Jt
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpIXS-0000mt-VI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:25:35 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpIXS-0000mf-NY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:25:30 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 137so23802069wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:25:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150463524785.11238.8706878766331677095.malone@wampee.canonical.com>
References: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
	<150463524785.11238.8706878766331677095.malone@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 19:25:08 +0100
Message-ID: <CAFEAcA8SK2JqjWoGBTXF7OWFT-FoA3v8JpH+zpBF9n-DswrLVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1715203] Re: Maintain Haiku support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1715203 <1715203@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 19:14, kallisti5 <1715203@bugs.launchpad.net> wrote:
> Haiku recently got a virtio driver, so running a Haiku system in cloud
> infrastructure seems possible now. (I've personally run it on vultr.com)
> Does QEMU have some infrastructure available so we can stand up a x86_64
> system?

Nope. We would be looking either for ssh login on a system somebody
else admins, or detailed instructions on how to set up a VM for it,
like the ones we have for BSD at https://wiki.qemu.org/index.php/Hosts/BSD

thanks
-- PMM

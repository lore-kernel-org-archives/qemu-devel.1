Received: from eggs.gnu.org ([2001:4830:134:3::10]:42008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1eBnZK-0004BZ-8O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1eBnZG-00089c-De
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:00:26 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:48668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jrtc27@jrtc27.com>) id 1eBnZG-00089E-5r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:00:22 -0500
Received: by mail-wr0-x241.google.com with SMTP id 15so9774204wrb.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 12:00:21 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
From: James Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20171106195748.GB19281@kos.to>
Date: Mon, 6 Nov 2017 20:00:18 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <EA04B1DD-4E66-43EE-9BAE-3DE39D609DB2@jrtc27.com>
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
	<f22e881a-466a-945b-2979-8c0851790854@physik.fu-berlin.de>
	<20171106195748.GB19281@kos.to>
Subject: Re: [Qemu-devel] [PATCH v3] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On 6 Nov 2017, at 19:57, Riku Voipio <riku.voipio@iki.fi> wrote:
> 
> On Wed, Oct 04, 2017 at 10:38:50AM +0200, John Paul Adrian Glaubitz wrote:
>> Hi!
>> 
>> Any chance that this patch gets merged soon?
>> 
>> Looks like it has been reviewed by at least Richard and Philippe.
> 
> Sorry, slipped under radar. Applied to linux-user.

Thanks! These things happen.

James

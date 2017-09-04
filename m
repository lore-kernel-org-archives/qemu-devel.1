Received: from eggs.gnu.org ([2001:4830:134:3::10]:48314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dovb6-0005ZB-Rl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dovb1-0004M9-T5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:55:44 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:51044
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dovb1-0004LB-M1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:55:39 -0400
References: <150442540217.17409.6458222878014636993.malonedeb@gac.canonical.com>
	<150453789823.8244.9432426777778032459.malone@soybean.canonical.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <1ffeb7f3-ca5f-aec5-df63-07d37d5c559a@weilnetz.de>
Date: Mon, 4 Sep 2017 19:55:33 +0200
MIME-Version: 1.0
In-Reply-To: <150453789823.8244.9432426777778032459.malone@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1714750] Re: 2.10.0 cannot be installed on
 case-insensitive file system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1714750 <1714750@bugs.launchpad.net>, qemu-devel@nongnu.org

Am 04.09.2017 um 17:11 schrieb Peter Maydell:
> Yes, it's awkward for users who are on OSX (or Windows, I assume).

Windows users who want to extract the tarball would have the same
problem. I don't think that there are many users who do that.

Nevertheless I have just sent an e-mail to the u-boot mailing list
(subscription worked for me, but my e-mail is still waiting
for the moderation) and also to the author who added the
relevant commit to u-boot.

u-boot v2017.09 is scheduled for 11 September 2017, so there is
a chance to get that fixed until then.

Regards
Stefan

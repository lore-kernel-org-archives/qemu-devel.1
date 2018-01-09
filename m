Received: from eggs.gnu.org ([2001:4830:134:3::10]:49748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxK0-00088F-Uj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxK0-0007li-87
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:04:20 -0500
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:49375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1eYxK0-0007lC-0N
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:04:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2018 18:04:18 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
	<4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
	<78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
	<77a5aebb06185f4de234d720d220fa57@walle.cc>
	<CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
Message-ID: <286a573eb67773dd93378579ee2499d5@walle.cc>
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org
	qemu-devel" <qemu-devel@nongnu.org>

Am 2018-01-09 12:58, schrieb Peter Maydell:
> I just fell over this, it looks like this fix never made it into 
> master.
> 
> Michael, could you submit this as a full patch with a commit message
> and signed-off-by, please? cc: qemu-stable@nongnu.org as well, since
> it fixes a "breaks the board completely" bug.

oops, sorry about that :(

-michael

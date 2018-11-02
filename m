Received: from eggs.gnu.org ([2001:4830:134:3::10]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIbhd-0008At-9v
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIbhU-0006hO-V7
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:49:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:37688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIbhP-0006gV-Q8
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:49:30 -0400
Date: Fri, 2 Nov 2018 16:49:23 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181102154923.GB2274@sx9>
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>
	<20181101172353.GA2316@sx9>
	<BN6PR2201MB12512B92322BFB8965848215C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181102143119.GA2274@sx9>
	<BN6PR2201MB12515D71ED36B637045DA6D2C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<CAFEAcA9KJn++ASQ+xzEAs+pi0xkZG7i3aPUZEQZXwRfYJy6jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9KJn++ASQ+xzEAs+pi0xkZG7i3aPUZEQZXwRfYJy6jbw@mail.gmail.com>
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Emilio G. Cota" <cota@braap.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi Peter,

> From the other side of things, as a submaintainer around release
> time there's often a lot of work to do and it's easy to confuse
> different patchsets or forget the status of them, so it's useful
> to have a patch series which is exactly the set of patches that
> the submitter thinks are suitable to go into the release, and it's
> less work to apply those than to fish out a subset of patches
> from a series.

Understood. Aleksandar previously indicated that he wanted an amendment
series with changes ordered by importance, which is why the two patches
were part of that series (as the first ones).

> So overall, I think my suggestion would be that the best move
> from here would be for Fred to send a patchset with the changes
> for 3.1 and only those changes. Could you do that, please?

Yes, I will post a separate series for review immediately.

Fredrik

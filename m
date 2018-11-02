Received: from eggs.gnu.org ([2001:4830:134:3::10]:49097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIaUE-0002dZ-1S
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIaUA-0007Rt-M2
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:31:45 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:45567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIaUA-0007My-EH
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:31:42 -0400
Date: Fri, 2 Nov 2018 15:31:19 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181102143119.GA2274@sx9>
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>
	<20181101172353.GA2316@sx9>
	<BN6PR2201MB12512B92322BFB8965848215C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12512B92322BFB8965848215C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Aleksandar,

> It is now code freeze before 3.1, the code base is being stabilized, and
> only important fixes are allowed to be integrated - so, in that light, a
> separate patch, or a small series, that addresses only concerns from the
> original mail of this thread is needed. Such series should not contain any
> additional features (like your v2 of the series "Amend..." does), and its
> patch titles should look like "Fix decoding mechanism of ..." or such.
> 
> Could you please provide those appropriate changes in that format?

I certainly could, but why not simply apply patch 1 and 2 in the posted
v2 series and leave the rest for later? The only difference in a repost
would be the cover letter. The two patches would be identical reposts
that apply since yesterday.

The patch series is ordered with "crucial patches as the first ones",
as you wanted it according to:

http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04946.html

Fredrik

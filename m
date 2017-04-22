Received: from eggs.gnu.org ([2001:4830:134:3::10]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d1zFt-000542-Q8
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d1zFs-0008PY-Pw
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:55:33 -0400
Date: Sat, 22 Apr 2017 17:41:55 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170422154155.cnberyxmr6bt2ghj@aurel32.net>
References: <cover.1492787889.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1492787889.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v7 00/13] Improvements for SM501 display
 controller emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2017-04-21 17:18, BALATON Zoltan wrote:
> v7: Define default values for some variables to avoid an (invalid)
>     warning from gcc 6 or 7 as suggested by Aurelien Jarno.

Thanks a lot for this new version, I confirm it now builds fine with GCC
6 or 7.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

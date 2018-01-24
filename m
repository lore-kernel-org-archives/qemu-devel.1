Received: from eggs.gnu.org ([2001:4830:134:3::10]:58091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeQzg-0003qH-Aa
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeQzd-0000Ni-75
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:46:00 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eeQzc-0000KL-T2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:45:57 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124185047.GA4518@bogon.m.sigxcpu.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <efa9445a-eede-e8e2-72ff-add7729fb275@vivier.eu>
Date: Wed, 24 Jan 2018 20:45:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180124185047.GA4518@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/11] linux-user: improve NETLINK strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Le 24/01/2018 à 19:50, Guido Günther a écrit :
> Hi,
> On Wed, Jan 24, 2018 at 10:01:15AM -0300, Philippe Mathieu-Daudé wrote:
>> Few patches I'v been writting while trying to figure out this issue:
>> http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> I can't comment code wise but it makes the -strace output much more
> useful in this area.

If you have tested the patches and found they work well, you can add a:

Tested-by: .....

Thanks,
Laurent

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehDOe-00016Z-Vt
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehDOb-0005lC-3a
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:51:17 -0500
Date: Thu, 1 Feb 2018 12:51:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180130194935.GL12900@umbus>
Message-ID: <alpine.BSF.2.21.1802011250090.39992@zero.eik.bme.hu>
References: <20180130131716.5899D7456D5@zero.eik.bme.hu>
	<20180130194935.GL12900@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] sii3112: Change angle brackets to quotes
 in #include lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Wed, 31 Jan 2018, David Gibson wrote:
> On Tue, Jan 30, 2018 at 02:10:10PM +0100, BALATON Zoltan wrote:
>> This matches what other files do for qemu includes
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Applied, thanks.

Thanks but Markus instead included this in his cleanup patches here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg00075.html
so you can drop this from your tree now.

Regards,
BALATON Zoltan

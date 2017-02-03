Received: from eggs.gnu.org ([2001:4830:134:3::10]:41380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdMW-0007c9-7n
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdMT-0002O3-4v
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:53:12 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:59975 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdMS-0002LJ-Pv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:53:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <114ea531-56b8-07ea-feb9-274593797747@huawei.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51inorwjjx.fsf@maestria.local.igalia.com>
	<136bc6e7-10af-479a-6c29-c783a833cc9a@huawei.com>
	<w51fujvwijb.fsf@maestria.local.igalia.com>
	<114ea531-56b8-07ea-feb9-274593797747@huawei.com>
Date: Fri, 03 Feb 2017 13:53:06 +0100
Message-ID: <w51d1ezwi4t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2 v16] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On Fri 03 Feb 2017 01:46:31 PM CET, Pradeep Jagadeesh wrote:
>> The false positive is not related to what Greg said :-) What you have
>> to put is not that URL but the Reviewed-by: line with Stefan's name
>> and e-mail.
>
> Haha OK. I will change it and send new patch set again.

I don't know if it's necessary now, but if you need to send the patch
again you have to keep your Signed-off-by line and my and Stefan's
Reviewed-by lines.

Berto

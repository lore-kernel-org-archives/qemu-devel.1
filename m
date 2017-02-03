Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdE8-0002L4-Th
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdE3-0002Tj-Tp
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:44:32 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:58761 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZdE3-0002Qc-AR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:44:27 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <136bc6e7-10af-479a-6c29-c783a833cc9a@huawei.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51inorwjjx.fsf@maestria.local.igalia.com>
	<136bc6e7-10af-479a-6c29-c783a833cc9a@huawei.com>
Date: Fri, 03 Feb 2017 13:44:24 +0100
Message-ID: <w51fujvwijb.fsf@maestria.local.igalia.com>
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

On Fri 03 Feb 2017 01:27:25 PM CET, Pradeep Jagadeesh wrote:

>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04637.html
>>
>> This line doesn't belong in the commit message.
>
> There is one false positive error in the second patch. So Greg asked
> me to put this line after SoB. Just to say that I had a positive
> review comment.

The false positive is not related to what Greg said :-) What you have to
put is not that URL but the Reviewed-by: line with Stefan's name and
e-mail.

Berto

Received: from eggs.gnu.org ([208.118.235.92]:34172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gcVoP-0007gp-At
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gcVn2-0004W1-8f
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:33:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gcVn2-0004Vb-2g
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:33:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so18351658wrw.1
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 05:33:32 -0800 (PST)
From: "=?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?=" <dirty.ice.hu@gmail.com>
References: <mailman.31873.1545598364.1282.qemu-devel@nongnu.org>
	<E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
Message-ID: <e87c0056-4150-0d5e-e049-d71750da1f17@gmail.com>
Date: Thu, 27 Dec 2018 14:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: hu-HU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi,

I've pushed it to my github (modulo some random fixes not yet on the
mailing list):
https://github.com/DirtYiCE/qemu/tree/audio-51-2018

I don't have a mac so I have no idea whether it works or not.

Regards,
Zoltan

On 2018-12-26 12:24, Programmingkid wrote:
> 
>> On Dec 23, 2018, at 3:52 PM, qemu-devel-request@nongnu.org wrote:
>>
>> Message: 4
>> Date: Sun, 23 Dec 2018 21:51:36 +0100
>> From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
>> 	<dirty.ice.hu@gmail.com>
>> To: qemu-devel@nongnu.org
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
>> Message-ID: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
>> Content-Type: text/plain; charset=UTF-8
>>
>> Hi,
>>
>> I've updated my audio patchset to the current git master. Other than that not
>> much happened since my last update [1], fixed a few small problems that I
>> noticed while rebasing my patches.
>>
>> Please review.
> 
> <snip>
> 
> Hi I would like to run your patches. Do you have a repository that I may clone? 
> 
> Also have you been able to test these patches using a Mac OS X guest yet? 
> 
> Thank you.
> 

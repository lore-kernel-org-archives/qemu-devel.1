Received: from eggs.gnu.org ([208.118.235.92]:59319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdx2-0000Ai-Kc
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdwu-0004W8-OM
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:16:22 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gcdwt-0004Se-S9
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 17:16:16 -0500
Received: by mail-ed1-x542.google.com with SMTP id d39so16228171edb.12
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 14:16:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <mailman.31873.1545598364.1282.qemu-devel@nongnu.org>
	<E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a2b1507-7770-f591-6f5c-378e689bc35b@amsat.org>
Date: Thu, 27 Dec 2018 23:16:11 +0100
MIME-Version: 1.0
In-Reply-To: <E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Programmingkid <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, dirty.ice.hu@gmail.com, Fam Zheng <fam@euphon.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi John,

On 12/26/18 12:24 PM, Programmingkid wrote:
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

                ^ [*]

>> Content-Type: text/plain; charset=UTF-8
>>
> <snip>
> 
> Hi I would like to run your patches. Do you have a repository that I may clone? 

Usually you can take series posted to the list via patchew, using the
following pattern:

https://github.com/patchew-project/qemu/releases/tag/patchew/$MESSAGE_ID

using the cover mail message ID without the angle brackets < >.

Here this would be:

https://github.com/patchew-project/qemu/releases/tag/patchew/cover.1545598229.git.DirtY.iCE.hu@gmail.com

but sadly patchew failed at applying this series :/

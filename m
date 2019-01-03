Received: from eggs.gnu.org ([208.118.235.92]:55121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3Pm-0000c1-TS
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3Pi-00073P-Se
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:52:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf3Pi-00073K-Mt
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:51:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so33689363wrr.0
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:51:58 -0800 (PST)
References: <1546443980-26779-1-git-send-email-thuth@redhat.com>
	<c2648f00-c44f-7f8e-8673-501b88f1e125@redhat.com>
	<17ed4887-1784-960e-d82e-ec90d98efc82@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ebf14ff-0a0a-c228-fc69-11f95f4b754a@redhat.com>
Date: Thu, 3 Jan 2019 14:51:56 +0100
MIME-Version: 1.0
In-Reply-To: <17ed4887-1784-960e-d82e-ec90d98efc82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing
 SPARC-related files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 1/3/19 8:19 AM, Thomas Huth wrote:
> On 2019-01-02 20:34, Philippe Mathieu-Daudé wrote:
[...]
>> I sent a patch to trivial@ with other sun4u changes, reviewed by Mark:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04467.html
> 
> Oh, right, sorry!
> 
>> Neither mine nor your are complete :)
>> Can I include your patch when respining the series? (Not sure I need to
>> respin although).
> 
> Sure!

Thanks :)

> 
>>> +F: include/hw/nvram/sun_nvram.h
>>
>> sun_nvram.h is also used by sun4m (the previous section this patch updates).
> 
> Right. So it should maybe be listed twice... (but since the maintainer
> of sun4u and sun4m is the same, it likely does not really matter)

Yes, this is true as of today, but maybe tomorrow the current maintainer
will give over one of these sections to someone else...

Received: from eggs.gnu.org ([209.51.188.92]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGye-0006z1-Ih
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGu0-0004W3-5i
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:18:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1guGtz-0004Tv-VU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:18:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id d15so6260997wmb.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:18:07 -0800 (PST)
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
	<20190213065357.16076-9-yuval.shaia@oracle.com>
	<d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
	<20190213144629.GA10728@lap1>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <cff72eab-5d25-8759-f9a2-954370b53171@gmail.com>
Date: Thu, 14 Feb 2019 15:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190213144629.GA10728@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/pvrdma: Delete unneeded function
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, dgilbert@redhat.com, armbru@redhat.com



On 2/13/19 4:46 PM, Yuval Shaia wrote:
> On Wed, Feb 13, 2019 at 01:40:34PM +0100, Philippe Mathieu-Daudé wrote:
>> On 2/13/19 7:53 AM, Yuval Shaia wrote:
>>> The function argument rdma_dev_res is not needed as it is stored in the
>>> backend_dev object at init.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
>> Should we teach checkpatch.pl to check name/space/email?
> Nice idea :)
>
> Marcel, i copied it from your signature so you may want to check it.
> Anyway, is re-spin needed or you can fix it for the PR?

No need, I will fix it.
Thanks,
Marcel

> Yuval

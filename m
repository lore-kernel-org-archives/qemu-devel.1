Received: from eggs.gnu.org ([2001:4830:134:3::10]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUj6c-0006SE-2o
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUj6Z-0003K1-CZ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:09:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44257
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUj6Y-0003Hp-UA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 21:09:31 -0500
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-2-git-send-email-lizhijian@cn.fujitsu.com>
	<92678cef-b2de-0eb6-d7c8-013f7adca4a2@redhat.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <09c493b0-9f67-efb8-2966-f3e5cda928af@cn.fujitsu.com>
Date: Thu, 6 Dec 2018 10:09:26 +0800
MIME-Version: 1.0
In-Reply-To: <92678cef-b2de-0eb6-d7c8-013f7adca4a2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 1/4] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, philip.li@intel.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


On 12/05/2018 01:40 AM, Philippe Mathieu-Daudé wrote:
> Hi Li,
>
> On 3/12/18 15:48, Li Zhijian wrote:
>> Some address/memory APIs have different type between
>> 'hwaddr/target_ulong addr' and 'int len'. It is very unsafety, espcially
> I'm not native English speaker, but I think this should be spell:
>
> ... "very unsafe, especially" ...

thanks, Google said so.

Thanks
Zhijian

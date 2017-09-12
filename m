Received: from eggs.gnu.org ([2001:4830:134:3::10]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1drZfn-000240-R7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1drZfk-0002Ae-Nk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:07:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48674
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1drZfk-000267-CM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:07:28 -0400
References: <20170901154542.5687-1-cascardo@canonical.com>
	<20170901161118.GQ7570@localhost.localdomain>
	<2ab3aaef-c6d7-ae3d-808b-f947dcb3ed1c@cn.fujitsu.com>
	<20170904130814.GR7570@localhost.localdomain>
	<e970608d-fb97-210c-72e9-bf4f43a3e54c@cn.fujitsu.com>
	<20170911125814.27a8d496@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <70fffb76-2273-7184-6dea-2b5788ec3b57@cn.fujitsu.com>
Date: Tue, 12 Sep 2017 08:58:49 +0800
MIME-Version: 1.0
In-Reply-To: <20170911125814.27a8d496@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86/acpi: build SRAT when memory hotplug
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

At 09/11/2017 06:58 PM, Igor Mammedov wrote:
>>> > >
>>> > > Igor's suggestion to enable NUMA implicitly sounds safer to me.
>>> > >
>> >
>> > I agree with Igor too.
>> >
>> > Is anybody doing this? If not, may I make a patch to enable adding NUMA
>> > node implicitly first. let's see what it looks like.
> As far as I'm aware nobody is doing it, so fill free to look into it.
>

Got it!  I will do it right now.

Thanks,
	dou.

>> >
>> > Thanks,
>> > 	dou.
>> >
>> >

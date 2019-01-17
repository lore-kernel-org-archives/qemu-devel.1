Received: from eggs.gnu.org ([209.51.188.92]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk59h-0007n5-UC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk4zM-00022D-OD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:33:34 -0500
References: <20190116041712.130183-1-aik@ozlabs.ru>
	<20190116124748.7c64c90e.cohuck@redhat.com>
	<96b377b0-7104-f123-c02d-a93364a3e119@redhat.com>
	<656ebcc1-da4a-2c98-2cd9-1db08b488616@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bf01484-d2ed-eb75-3f19-1d15b73cfd2c@redhat.com>
Date: Thu, 17 Jan 2019 11:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <656ebcc1-da4a-2c98-2cd9-1db08b488616@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/2] linux-headers: Update to v5.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 17/01/19 01:04, Alexey Kardashevskiy wrote:
> 
> 
> On 16/01/2019 22:49, Paolo Bonzini wrote:
>> On 16/01/19 12:47, Cornelia Huck wrote:
>>> On Wed, 16 Jan 2019 15:17:10 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>> Here is the update script update and what it did to the v5.0-rc2 kernel.
>>>>
>>>> This is based on sha1
>>>> a0a8bff Greg Kurz "target/ppc/kvm: Drop useless include directive".
>>>>
>>>> Please comment. Thanks.
>>>
>>> Hm, Paolo had already posted an update to -rc1 (including an update of
>>> the script). Not sure what the status of that one is?
>>
>> It's queued in my next pull request.
> 
> Is this in any publicly available git tree?

No, but I'll shortly start marking queued patches in Patchew and you'll
be able to query them as "query:bonzini".

Paolo

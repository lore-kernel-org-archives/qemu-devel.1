Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce2tX-0001BB-Hi
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce2tW-0001gs-Gw
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ce2tW-0001gS-AY
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60DF1C054C55
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 16:57:30 +0000 (UTC)
References: <06BE8A21-A1E9-4264-BD02-04A566748633@redhat.com>
	<173cba42-5390-0e16-71a3-3eadcd3ef654@redhat.com>
	<9657908C-A71B-424E-BBFD-E4A8EEF1C178@redhat.com>
	<416ddd00-7348-a7c7-54c0-6f0754e7d062@redhat.com>
	<20170215163232.GL24672@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09c9cfe1-0ebb-9393-6ea8-2aeb99650225@redhat.com>
Date: Wed, 15 Feb 2017 17:57:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170215163232.GL24672@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] VirtIO Windows Driver repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>, Bandan Das <bsd@redhat.com>

CC Bandan

On 02/15/17 17:32, Daniel P. Berrange wrote:
> On Wed, Feb 15, 2017 at 05:27:59PM +0100, Laszlo Ersek wrote:
>> On 02/15/17 16:15, Yan Vugenfirer wrote:
>>>
>>>> On 14 Feb 2017, at 16:08, Laszlo Ersek <lersek@redhat.com> wrote:
>>>>
>>>> On 02/14/17 13:40, Yan Vugenfirer wrote:
>>>>> Hello All,
>>>>>
>>>>> The official upstream repository moved from
>>>>> https://github.com/YanVugenfirer/kvm-guest-drivers-windows to
>>>>> https://github.com/virtio-win/kvm-guest-drivers-windows
>>>>>
>>>>> Best regards, Yan Vugenfirer.
>>>>
>>>> Thanks! I've updated the corresponding reference under
>>>> <https://fedoraproject.org/wiki/Windows_Virtio_Drivers#Links>.
>>>
>>> Thanks!
>>>
>>> Do you know who can make a change on
>>> http://www.linux-kvm.org/page/WindowsGuestDrivers/Repository ?
>>
>> I thought that I had page editing permissions, and indeed when I edit
>> the page and hit "Save", I'm presented with the updated version.
>> However, as soon as I re-visit the page, the old version is shown, and I
>> can't find my changes in the page history either.
>>
>> Dan, can you pls help?
> 
> I'm not admin for the KVM wiki - try Jeff Cody iirc

In parallel, Bandan notified me off-list that the KVM wiki reported my
editing as a "spam attempt". Bandan has now placed me in the right
group, and I've updated the page successfully. (I think.)

Thanks all!
Laszlo

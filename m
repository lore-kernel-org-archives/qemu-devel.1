Received: from eggs.gnu.org ([2001:4830:134:3::10]:59301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgoH-0006Qf-6M
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgoD-0000A0-1e
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:26:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgoC-00009q-Rj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:26:16 -0400
References: <20180511081601.14610.39946.stgit@pasha-VirtualBox>
	<377a43be-ec70-f8d0-450e-c71d239685a1@redhat.com>
	<002601d449b8$d1b299a0$7517cce0$@ru>
	<480acfa6-665a-5377-57d9-2dffa269b617@redhat.com>
	<20180911112539.vsogar3t5q3xnpci@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca64ea70-8f28-e61d-b047-04b2fd55dc60@redhat.com>
Date: Tue, 11 Sep 2018 13:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180911112539.vsogar3t5q3xnpci@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ps2: prevent changing irq state on save
 and load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, arei.gonglei@huawei.com, mst@redhat.com, ciro.santilli@gmail.com, maria.klimushenkova@ispras.ru

On 11/09/2018 13:25, Gerd Hoffmann wrote:
> On Tue, Sep 11, 2018 at 01:10:56PM +0200, Paolo Bonzini wrote:
>> On 11/09/2018 12:18, Pavel Dovgalyuk wrote:
>>> Paolo, have you forgot about this?
>>>
>>> Pavel Dovgalyuk
>>
>> Yes, though Gerd might be a better match for the patch.
> 
> Dropped it from my patch mailbox after seeing your 'queued' message.
> 
> Pavel, can you resend?

No need, I'll queue it for real now. :)

Paolo

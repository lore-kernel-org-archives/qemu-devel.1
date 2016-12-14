Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHCu8-0004kG-EH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHCu3-0005Ie-GH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:59:44 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHCu3-00058N-9z
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:59:39 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so5856117wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 08:59:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1478330391-74060-1-git-send-email-chao.p.peng@linux.intel.com>
	<1478330391-74060-5-git-send-email-chao.p.peng@linux.intel.com>
	<20161106090458-mutt-send-email-mst@kernel.org>
	<9536bb8a-aec8-c03b-4b86-b40ce18f6d26@redhat.com>
	<1479110762.2421.20.camel@linux.intel.com>
	<20161114225108-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fec880fc-89af-a934-858d-4e4e38173706@redhat.com>
Date: Wed, 14 Dec 2016 17:58:13 +0100
MIME-Version: 1.0
In-Reply-To: <20161114225108-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] q35: introduce q35-lite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 14/11/2016 21:51, Michael S. Tsirkin wrote:
> On Mon, Nov 14, 2016 at 04:06:02PM +0800, Chao Peng wrote:
>> On Mon, 2016-11-07 at 18:09 +0100, Paolo Bonzini wrote:
>>>
>>> On 06/11/2016 08:06, Michael S. Tsirkin wrote:
>>>>
>>>> On Sat, Nov 05, 2016 at 03:19:51AM -0400, Chao Peng wrote:
>>>>>
>>>>>>
>>>>>> This patch introduces a light weight machine type which shares
>>>>>> the
>>>>>> same codebase with existing q35 machine type but with some
>>>>>> features
>>>>>> disabled by default.
>>>>>>
>>>>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>>> I don't find this too useful, but if others do and send acks, I'll
>>>> merge
>>>> it, but only if it also has migration disabled.
>>>>
>>>
>>> Agreed, it's enough to have patches 1-3.
>>>
>>
>> I'm fine.
> 
> Pls post just the correct patches after the release.

Since I was cleaning my inbox, I've already queued 1-3.

Paolo

Received: from eggs.gnu.org ([209.51.188.92]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF5K-0003qb-T5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF5J-0003VA-Ru
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:44:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmF5J-0003IJ-HY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:44:37 -0500
References: <1544684731-18828-1-git-send-email-thuth@redhat.com>
	<9be7ef6d-15b2-6e82-7beb-aeb287b50c3b@redhat.com>
	<cdb2688d-3495-bfe0-3cfe-0424d310f37c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57a473aa-e872-b530-28a3-ac98093d5413@redhat.com>
Date: Wed, 23 Jan 2019 10:44:06 +0100
MIME-Version: 1.0
In-Reply-To: <cdb2688d-3495-bfe0-3cfe-0424d310f37c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Remove deprecated
 "-virtioconsole" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

On 23/01/19 06:46, Thomas Huth wrote:
> On 2018-12-13 14:18, Paolo Bonzini wrote:
>> On 13/12/18 08:05, Thomas Huth wrote:
>>> It's been deprecated since QEMU 3.0, and nobody complained so far, so
>>> it is time to remove this option now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Queued (for the next pull request, not this one).
> 
> Ping? ... looks like this might have fallen through the cracks?
> 
>  Thomas
> 
> 

Queued, thanks.

Paolo

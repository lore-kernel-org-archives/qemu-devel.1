Received: from eggs.gnu.org ([2001:4830:134:3::10]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQgK5-00062j-Ew
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQgK4-0007s1-MV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:45:57 -0400
References: <20170628175534.14295-1-eblake@redhat.com>
	<4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
	<aa0a6484-f676-bf9f-393c-be6e9e5ed8b8@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3bad6d40-172c-3061-fad2-7033372ecbf8@redhat.com>
Date: Thu, 29 Jun 2017 16:45:47 -0400
MIME-Version: 1.0
In-Reply-To: <aa0a6484-f676-bf9f-393c-be6e9e5ed8b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 06/29/2017 11:11 AM, Eric Blake wrote:
> On 06/29/2017 03:28 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> Can we apply my "[PATCH v22 00/30] qcow2: persistent dirty bitmaps"
>> first? It was already near to the victory a week ago, but I had to
>> rebase it on new Paolo's patches.
> 
> Sure, I can rebase on top of yours (I've already rebased multiple times,
> as have you, but yours has been on the list longer).
> 

I would normally like to feign impartiality, but in this case I'd really
prefer if Vladimir's patches went through first, too.

--js

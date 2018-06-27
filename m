Received: from eggs.gnu.org ([2001:4830:134:3::10]:35391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY5mA-0004ZT-Na
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY5m7-0007tV-Fy
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:26:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fY5m7-0007s3-9k
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:26:03 -0400
References: <1528895946-28677-1-git-send-email-eric.auger@redhat.com>
	<9830d5df-c36d-1bb3-799b-bfe1f7b93b29@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8108c63d-c755-c682-7529-91ac0c676bf3@redhat.com>
Date: Wed, 27 Jun 2018 10:26:00 +0200
MIME-Version: 1.0
In-Reply-To: <9830d5df-c36d-1bb3-799b-bfe1f7b93b29@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com

On 26/06/2018 22:29, Auger Eric wrote:
>>
>> Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> gentle reminder, just to make sure someone is going to pick up this
> patch before the freeze ;-) Or please let me know if I miss some concerns.

Yes, it's already queued.

Paolo

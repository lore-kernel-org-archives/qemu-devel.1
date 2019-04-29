Received: from eggs.gnu.org ([209.51.188.92]:48530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3R9-0006gF-Ch
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3Kn-0005oO-Qe
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:16:30 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-11-borntraeger@de.ibm.com>
	<71955bba-ef04-1677-b7f0-bb1675bad12a@redhat.com>
	<07252560-1eed-8fd5-ee94-6bcea6cf99bc@de.ibm.com>
	<10d43e6e-ee8c-cd65-e724-354e0f40c79f@redhat.com>
	<057d438c-2062-1aa7-887a-918f076911c5@de.ibm.com>
	<93f0ecac-47cc-c791-9e32-ad5743489bf3@redhat.com>
	<20190426145506.409b53cf.cohuck@redhat.com>
	<7157e9b3-4432-32cc-9327-22e0d0124987@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fcf4a57e-efa5-557e-e38a-6ad2c253ef14@redhat.com>
Date: Mon, 29 Apr 2019 12:16:22 +0200
MIME-Version: 1.0
In-Reply-To: <7157e9b3-4432-32cc-9327-22e0d0124987@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 10/10] s390x/cpumodel: wire
 up 8561 and 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

> I dont think that I know the name in time before the next release.
> So lets go with gen15a/gen15b or 8561/8562?
> 

We can still fixup if the names happen to be known earlier.

-- 

Thanks,

David / dhildenb

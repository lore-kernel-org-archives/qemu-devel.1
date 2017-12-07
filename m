Received: from eggs.gnu.org ([2001:4830:134:3::10]:33087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN63e-000076-J7
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN63b-0007nr-J6
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:58:26 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-11-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e3d4000b-3170-a79f-cd02-0335c2706d9f@twiddle.net>
Date: Thu, 7 Dec 2017 15:58:20 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 10/10] s390x: change the QEMU
 cpu model to a stripped down z12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 12/07/2017 08:53 AM, David Hildenbrand wrote:
> +    const S390FeatBitmap qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };

static const?


r~

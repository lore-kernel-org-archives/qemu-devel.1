Received: from eggs.gnu.org ([2001:4830:134:3::10]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppnz-0004Vl-OA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dppnv-0002eT-EC
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:56:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dppnv-0002eG-7d
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:56:43 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3085f957-1902-8dc5-4404-c9517b994389@redhat.com>
Date: Thu, 7 Sep 2017 07:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/19] s390x: move
 s390_virtio_hypercall() to s390-virtio-hcall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 04.09.2017 17:43, David Hildenbrand wrote:
> Implemented in hw/s390x/s390-virtio-hcall.c, so let's move it to the
> right header file.

That's fair.

Reviewed-by: Thomas Huth <thuth@redhat.com>

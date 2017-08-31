Received: from eggs.gnu.org ([2001:4830:134:3::10]:53473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPHc-0007sf-1h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPHY-00084V-2k
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPHX-00084M-SJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:13:16 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-5-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4c02030a-61e2-da40-3f88-3f15aae44cb8@redhat.com>
Date: Thu, 31 Aug 2017 15:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/11] s390x: get rid of s390-virtio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:05, David Hildenbrand wrote:
> It is a leftover from the days where we had still the !ccw virtio
> machine. As this one is long gone, let's move everything to
> s390-virtio-ccw.c.
> 
> Cornelia Huck <cohuck@redhat.com>

I will add the missing Suggested-by: :)

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---



-- 

Thanks,

David

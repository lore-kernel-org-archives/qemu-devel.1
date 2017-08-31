Received: from eggs.gnu.org ([2001:4830:134:3::10]:53837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPIv-00008v-Oy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPIr-0008ST-OA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPIr-0008SG-HG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:37 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-5-david@redhat.com>
	<782fdf4f-084e-9fcb-f788-d2f0c7f5340c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <107c8ace-952d-1453-c23d-1b3b4c404db0@redhat.com>
Date: Thu, 31 Aug 2017 15:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <782fdf4f-084e-9fcb-f788-d2f0c7f5340c@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>


>> +    return 0;
>> +}
>> +
>> +
> 
> Nit: One empty line should be enough here.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Indeed, thanks!

-- 

Thanks,

David

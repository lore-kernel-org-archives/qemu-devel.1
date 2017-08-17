Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diHJ4-0003cW-0k
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diHIz-0002Tj-54
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:41:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diHIy-0002TQ-UU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:41:33 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-2-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b59243aa-1ac4-b931-73ba-450efa1b80d6@redhat.com>
Date: Thu, 17 Aug 2017 11:41:22 +0200
MIME-Version: 1.0
In-Reply-To: <1502951113-4246-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Run filter-redirector and
 -mirror test only on POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On 17.08.2017 08:25, Thomas Huth wrote:
> This way we can get rid of the ugly #ifdefs in the code which makes
> it easier to extend later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David

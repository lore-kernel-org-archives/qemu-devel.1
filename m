Received: from eggs.gnu.org ([209.51.188.92]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hBPqN-00017U-IX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hBPqM-0003kW-Hk
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33378
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hBPqM-0003jp-AV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:17:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x32KDxj5047408
	for <qemu-devel@nongnu.org>; Tue, 2 Apr 2019 16:17:13 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rmedggmsf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 16:17:13 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 2 Apr 2019 21:17:12 +0100
From: Collin Walling <walling@linux.ibm.com>
References: <20190401214847.27600-1-walling@linux.ibm.com>
Date: Tue, 2 Apr 2019 16:17:07 -0400
MIME-Version: 1.0
In-Reply-To: <20190401214847.27600-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a7bb6f96-5275-2181-7ea3-2f7187883f4c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] s390: diagnose 318 info reset and
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com

On 4/1/19 5:48 PM, Collin Walling wrote:

[...]

> ---
> 
> This version is posted in tandem with a new kernel patch that changes
> how the execution of the diag 0x318 instruction is handled. A link to
> this series will be attached as a reply to this series for convenience.
> 

https://www.spinics.net/lists/linux-s390/msg24661.html

[...]

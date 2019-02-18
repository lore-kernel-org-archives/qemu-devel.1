Received: from eggs.gnu.org ([209.51.188.92]:44834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvmK2-0004nr-1e
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvmJw-0002Ug-9d
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:03:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gvmJv-0002Tt-Ts
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:03:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1IGsqJj062333
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 12:03:05 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qqx7g97wh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 12:03:04 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 18 Feb 2019 17:03:03 -0000
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<e2394dc4-1d95-2c23-5e11-cff441d57c78@linux.ibm.com>
	<20190206093459.15fa733a@Igors-MacBook-Pro.local>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 18 Feb 2019 12:02:58 -0500
MIME-Version: 1.0
In-Reply-To: <20190206093459.15fa733a@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <233af73c-0b65-fef7-1a42-bce99eb5ec88@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, pmorel@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 2/6/19 3:34 AM, Igor Mammedov wrote:
> On Mon, 28 Jan 2019 15:35:09 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:

ping!

Who is the maintainer responsible for merging this?

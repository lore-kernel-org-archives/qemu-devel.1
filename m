Received: from eggs.gnu.org ([2001:4830:134:3::10]:47328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duBdH-0000qG-7h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duBdC-0003H4-8J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:03:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1duBdB-0003Ga-Vt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 02:03:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8J60hkD051204
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:03:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2nvg2ufm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:03:36 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 00:03:35 -0600
Date: Tue, 19 Sep 2017 14:03:31 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
	<f06e081a-aff4-f2db-5741-b1f85f98f995@linux.vnet.ibm.com>
	<20170907125220.0d78d285.cohuck@redhat.com>
	<20170908020134.GG31680@bjsdjshi@linux.vnet.ibm.com>
	<61b525d8-a1a2-1e70-4c19-a9b7673f1cbe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b525d8-a1a2-1e70-4c19-a9b7673f1cbe@linux.vnet.ibm.com>
Message-Id: <20170919060331.GF5274@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-08 12:28:03 +0200]:

[snip]

> > What Halil pointed out is that the ccw_cb implementation of 3270
> > emulation does not take care of IDALs. This is true.
> > 
> > I can also do that right after this series, if Halil agrees.
> > (The 3270 emulation authors are busy of other stuff these days. :()
> 
> Generally, yes I agree. If it's trivial I will probably do it myself
> for v2. I need to do a v2 anyway.
> 
> Halil

I saw you are working on this. So leave it to you. ;)

-- 
Dong Jia Shi

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnQM-0000Ky-Vz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnQI-0001Oq-ES
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:39:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cjnQI-0001Ok-8Y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:39:06 -0500
Date: Fri, 3 Mar 2017 21:39:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170303133902.GH7097@lemon.lan>
References: <148847238435.285.7158100214182923369@0e2666bad730>
	<e58e0463-c12f-31ed-3944-a09735e7a7fc@de.ibm.com>
	<20170303095301.GE7097@lemon.lan>
	<7010a04e-a8c0-16a9-c9bf-c22e32b521c3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7010a04e-a8c0-16a9-c9bf-c22e32b521c3@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Fri, 03/03 14:22, Christian Borntraeger wrote:
> On 03/03/2017 10:53 AM, Fam Zheng wrote:
> > On Fri, 03/03 09:12, Christian Borntraeger wrote:
> >> On 03/02/2017 05:33 PM, no-reply@patchew.org wrote:
> >>
> >> Fam, this seems to happen sometimes. Can you have a look at that why the qtest 
> >> thing fails on the s390 box?
> > 
> > I don't know, when I run the commands manually for a few times, it is not
> > reproduced. :(
> > 
> > Fam
> 
> Any chance to add V=1 to the make check, so that we get the full testcase output?
> 
> 

Yes, I can do that.

Fam

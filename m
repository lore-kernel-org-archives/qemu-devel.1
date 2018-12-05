Received: from eggs.gnu.org ([2001:4830:134:3::10]:56490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUZ0T-0002Oe-Hz
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUZ0Q-00052Z-9a
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:22:33 -0500
Date: Wed, 5 Dec 2018 16:22:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181205162221.5f537ce7.cohuck@redhat.com>
In-Reply-To: <cdc9ce9e-18fb-5152-ba7d-33326d46a05d@linux.ibm.com>
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<76a5ccbc-69db-7876-478e-fba565b3a126@de.ibm.com>
	<cdc9ce9e-18fb-5152-ba7d-33326d46a05d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390: guest support for diagnose 318
 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, david@redhat.com, mimu@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com

On Wed, 5 Dec 2018 09:59:54 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 12/5/18 3:29 AM, Christian Borntraeger wrote:
> > You should clearly review your email list.....
> > 
> > Adding the "new" Conny, removing Carsten.
> >   
> 
> Thanks for taking care of that. I'll be more careful when using the
> addresses at the top of the files. 

scripts/get_maintainer.pl -f <file> is probably more useful to get
current addresses :)

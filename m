Received: from eggs.gnu.org ([2001:4830:134:3::10]:45516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1erifm-0003Jo-U9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1erifi-0000rg-Rt
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:16:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41932
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1erifi-0000rU-Li
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:16:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22BFgQU064190
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 06:16:18 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gf2j2ygwg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:16:17 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 11:16:16 -0000
References: <20180227173251.17025-1-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 12:16:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180227173251.17025-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <81bfac47-1e89-6ca2-aa10-32e1b0d5a86e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: license text should indicate GPL
 v2 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

On 27/02/2018 18:32, Cornelia Huck wrote:
> The license text currently specifies "any version" of the GPL. It
> is unlikely that GPL v1 was ever intended; change this to the
> standard "or any later version" text.
>
> Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Cc: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/vfio/ccw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 16713f2c52..4e5855741a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -6,8 +6,8 @@
>    *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>    *            Pierre Morel <pmorel@linux.vnet.ibm.com>
>    *
> - * This work is licensed under the terms of the GNU GPL, version 2 or(=
at
> - * your option) any version. See the COPYING file in the top-level
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
>    * directory.
>    */
>

Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCnOp-00052d-EH
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCnOj-0001nH-VN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:01:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCnOj-0001mq-MN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:01:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA9E0MTC068838
	for <qemu-devel@nongnu.org>; Thu, 9 Nov 2017 09:01:30 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e4n77tka7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 09:01:23 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 9 Nov 2017 07:01:16 -0700
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1014244176.38500883.1510231349539.JavaMail.zimbra@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 9 Nov 2017 09:01:13 -0500
MIME-Version: 1.0
In-Reply-To: <1014244176.38500883.1510231349539.JavaMail.zimbra@redhat.com>
Message-Id: <17766f2c-85a5-ba33-8bba-d5c29510982e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tpm: Match frontend and backend
 buffer sizes (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: amarnath valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 11/09/2017 07:42 AM, Marc-Andr=C3=A9 Lureau wrote:
> Reviewed-by: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>

Thanks! I added it to the tpm-next branch.

https://github.com/stefanberger/qemu-tpm/commits/tpm-next


     Stefan

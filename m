Received: from eggs.gnu.org ([2001:4830:134:3::10]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoqCq-0004Po-DB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoqCn-0002Mc-7v
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:42:36 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70f37041-309d-c131-51be-5c6c8488e63d@redhat.com>
Date: Thu, 22 Feb 2018 13:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 00/13] Interactive Boot
 Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, eblake@redhat.com

On 22.02.2018 12:51, Christian Borntraeger wrote:
> Series
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

OK, thanks.

I can pick up the patches from this series and fix the comment in patch
5 and the missing break in patch 13 manually, no need to resend so far.

> menu on scsi and dasd bootmaps tested successfully.
> 
> There is one thing that we might want to fix (can be an addon patch since this is a non-customer
> scenario (no libvirt)).

I agree that this can be an add-on patch.

 Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUCcK-0006GF-Ez
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUCcJ-0003Hj-LC
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:28:08 -0500
References: <154389473902.16407.61981583759630749@c26723477dc9>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5018bb45-7154-048c-e6de-cf2d68788979@redhat.com>
Date: Tue, 4 Dec 2018 09:27:54 -0600
MIME-Version: 1.0
In-Reply-To: <154389473902.16407.61981583759630749@c26723477dc9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-next 0/6] qemu-img: Add salvaging mode
 to convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, patchew-devel@redhat.com, mreitz@redhat.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com

On 12/3/18 9:39 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20181203175211.8230-1-mreitz@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 

> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: unable to access 'https://github.com/patchew-project/qemu/': Operation timed out after 300008 milliseconds with 0 out of 0 bytes received

False negative. It would be nice to figure out why patchew had a 
connection problem, but it would also be nice if patchew didn't send out 
failure notices when the failure is due to a git clone issue unrelated 
to the patch itself.

> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

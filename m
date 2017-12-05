Received: from eggs.gnu.org ([2001:4830:134:3::10]:50566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMH0v-00081W-NU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMH0v-0006q7-1f
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:28:13 -0500
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
	<51f11f12-3cd1-2db0-8969-1c5b2cdcdae4@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <226b86ac-8575-5f45-2a8f-586faf845c13@virtuozzo.com>
Date: Tue, 5 Dec 2017 20:28:00 +0300
MIME-Version: 1.0
In-Reply-To: <51f11f12-3cd1-2db0-8969-1c5b2cdcdae4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 00/15] qcow2: space
 preallocation and COW improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

On 5/12/2017 1:32 AM, John Snow wrote:
> Friendly ping; this has gone over 30 days without a reply on the list. I
> recommend rebasing and trying again after 2.11 hits.
> 
> Thanks,
> --John
> 

Thank you; I also though of maybe splitting this series in two i.e.
patches ~1-8 and then the actual preallocation ahead.
Will do.

/Anton

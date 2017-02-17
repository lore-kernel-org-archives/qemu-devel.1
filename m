Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cefct-0005SD-2t
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cefcs-0007IQ-9z
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:55 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1404 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cefcr-0007Hg-UU
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:54 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
	<20170216142144.GG4869@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
Date: Fri, 17 Feb 2017 13:18:38 +0300
MIME-Version: 1.0
In-Reply-To: <20170216142144.GG4869@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

16.02.2017 17:21, Kevin Wolf wrote:
> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Add detailed error messages.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Why not merge this patch into the one that originally introduced the
> function?

Just to not create extra work for reviewers

>
> Kevin


-- 
Best regards,
Vladimir

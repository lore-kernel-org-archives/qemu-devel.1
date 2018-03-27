Received: from eggs.gnu.org ([2001:4830:134:3::10]:33512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qSG-0008UH-Gq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qSC-0005Jp-G3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:24:08 -0400
References: <1522163370-18544-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0de5dc9-a6ab-7902-3977-b99fc1567ac8@redhat.com>
Date: Tue, 27 Mar 2018 10:24:03 -0500
MIME-Version: 1.0
In-Reply-To: <1522163370-18544-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] configure: Add missing configure
 options to help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/27/2018 10:09 AM, Thomas Huth wrote:
> We forgot to mention --with-git, --libexecdir and --with-pkgversion
> so far.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure | 3 +++
>   1 file changed, 3 insertions(+)

Useful for the release, and safe whether it makes -rc1 or -rc2.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

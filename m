Received: from eggs.gnu.org ([2001:4830:134:3::10]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db4W5-0006bb-Mv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db4W2-0004N0-64
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:37:17 -0400
Date: Fri, 28 Jul 2017 14:37:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728143709.5bfee839@gondolin>
In-Reply-To: <3a4f3a2a-cebc-e730-4a63-2616a17f5f2b@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-6-f4bug@amsat.org>
	<a7fdc125-9a1b-bec3-915f-e8f764816b0d@redhat.com>
	<c44770f5-df9d-2340-5dba-2f5db7acd046@redhat.com>
	<20170728135614.3f14e3ad@gondolin>
	<3abbfa87-d882-39ab-b4ab-66f3e68a2fb4@redhat.com>
	<20170728141353.3b8382be@gondolin>
	<3a4f3a2a-cebc-e730-4a63-2616a17f5f2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/47] MAINTAINERS: add missing KVM entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Fri, 28 Jul 2017 14:25:08 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Sometime people pull changes too early, or otherwise I want to comment
> on the timing of the change...

Might be helpful to add magic to checkpatch to verify that any headers
change is done via running the script against a specified Linux
version. (This is beyond my non-existing perl skills, unfortunately.)

> I don't know, I already get too much
> qemu-devel email. :)

I can certainly agree with that statement :)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnNWW-0008TW-Tt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnNWT-0006Ir-42
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:48:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnNWS-0006IN-U7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:48:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170309132216.23482-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 9 Mar 2017 13:22:15 +0000")
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Mar 2017 11:48:13 +0100
Message-ID: <87a88ph2qa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com, pasic@linux.vnet.ibm.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Provide a helper to say whether a RAMBlock was created as a
> shared mapping.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
